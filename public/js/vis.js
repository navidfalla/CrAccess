var width = $("div#vis").width(),     // svg width
    height = 350,     // svg height
    dr = 5,      // default point radius
    off = 15,    // cluster hull offset
    expand = {}, // expanded clusters
    data, net, force, hullg, hull, linkg, link, nodeg, node;
var current_issue;

var curve = d3.svg.line()
    .interpolate("cardinal-closed")
    .tension(.85);

var fill = d3.scale.category20();

function noop() { return false; }

function nodeid(n) {
  return n.size ? "_g_"+n.group : n.name;
}

function linkid(l) {
  var u = nodeid(l.source),
      v = nodeid(l.target);
  return u<v ? u+"|"+v : v+"|"+u;
}

function getGroup(n) { return n.group; }

// constructs the network to visualize
function network(data, prev, index, expand) {
  expand = expand || {};
  var gm = {},    // group map
      nm = {},    // node map
      lm = {},    // link map
      gn = {},    // previous group nodes
      gc = {},    // previous group centroids
      nodes = [], // output nodes
      links = []; // output links

  // process previous nodes for reuse or centroid calculation
  if (prev) {
    prev.nodes.forEach(function(n) {
      var i = index(n), o;
      if (n.size > 0) {
        gn[i] = n;
        n.size = 0;
      } else {
        o = gc[i] || (gc[i] = {x:0,y:0,count:0});
        o.x += n.x;
        o.y += n.y;
        o.count += 1;
      }
    });
  }

  // determine nodes
  for (var k=0; k<data.nodes.length; ++k) {
    var n = data.nodes[k],
        i = index(n),
        l = gm[i] || (gm[i]=gn[i]) || (gm[i]={group:i, size:0, nodes:[]});

    if (expand[i]) {
      // the node should be directly visible
      nm[n.name] = nodes.length;
      nodes.push(n);
      if (gn[i]) {
        // place new nodes at cluster location (plus jitter)
        n.x = gn[i].x + Math.random();
        n.y = gn[i].y + Math.random();
      }
    } else {
      // the node is part of a collapsed cluster
      if (l.size == 0) {
        // if new cluster, add to set and position at centroid of leaf nodes
        nm[i] = nodes.length;
        nodes.push(l);
        if (gc[i]) {
          l.x = gc[i].x / gc[i].count;
          l.y = gc[i].y / gc[i].count;
        }
      }
      l.nodes.push(n);
    }
  // always count group size as we also use it to tweak the force graph strengths/distances
    l.size += 1;
  n.group_data = l;
  }

  for (i in gm) { gm[i].link_count = 0; }

  // determine links
  for (k=0; k<data.links.length; ++k) {
    var e = data.links[k],
        u = index(e.source),
        v = index(e.target);
  if (u != v) {
    gm[u].link_count++;
    gm[v].link_count++;
  }
    u = expand[u] ? nm[e.source.name] : nm[u];
    v = expand[v] ? nm[e.target.name] : nm[v];
    var i = (u<v ? u+"|"+v : v+"|"+u),
        l = lm[i] || (lm[i] = {source:u, target:v, size:0});
    l.size += 1;
  }
  for (i in lm) { links.push(lm[i]); }

  return {nodes: nodes, links: links};
}

function convexHulls(nodes, index, offset) {
  var hulls = {};

  // create point sets
  for (var k=0; k<nodes.length; ++k) {
    var n = nodes[k];
    if (n.size) continue;
    var i = index(n),
        l = hulls[i] || (hulls[i] = []);
    l.push([n.x-offset, n.y-offset]);
    l.push([n.x-offset, n.y+offset]);
    l.push([n.x+offset, n.y-offset]);
    l.push([n.x+offset, n.y+offset]);
  }

  // create convex hulls
  var hullset = [];
  for (i in hulls) {
    hullset.push({group: i, path: d3.geom.hull(hulls[i])});
  }

  return hullset;
}

function drawCluster(d) {
  return curve(d.path); // 0.8
}

// --------------------------------------------------------

var body = d3.select("div#vis");

var vis = body.append("svg")
   .attr("width", width)
   .attr("height", height);

function load(){
    d3.json(baseURL+'/issues/vizData', function(json) {
      data = json;
      // console.log(data);
      for (var i=0; i<data.links.length; ++i) {
        o = data.links[i];
        o.source = data.nodes[o.source];
        o.target = data.nodes[o.target];
      }

      hullg = vis.append("g");
      linkg = vis.append("g");
      nodeg = vis.append("g");

      init();

      vis.attr("opacity", 1e-6)
        .transition()
          .duration(1000)
          .attr("opacity", 0.8);
    });
}
load();
function init() {
  if (force) force.stop();

  net = network(data, net, getGroup, expand);

  force = d3.layout.force()
      .nodes(net.nodes)
      .links(net.links)
      .size([width, height])
      .linkDistance(function(l, i) {
      var n1 = l.source, n2 = l.target;
    // larger distance for bigger groups:
    // both between single nodes and _other_ groups (where size of own node group still counts),
    // and between two group nodes.
    //
    // reduce distance for groups with very few outer links,
    // again both in expanded and grouped div#currentIssue, i.e. between individual nodes of a group and
    // nodes of another group or other group node or between two group nodes.
    //
    // The latter was done to keep the single-link groups ('blue', rose, ...) close.
    return 70 +
      Math.min(20 * Math.min((n1.size || (n1.group != n2.group ? n1.group_data.size : 0)),
                             (n2.size || (n1.group != n2.group ? n2.group_data.size : 0))),
           -30 +
           30 * Math.min((n1.link_count || (n1.group != n2.group ? n1.group_data.link_count : 0)),
                         (n2.link_count || (n1.group != n2.group ? n2.group_data.link_count : 0))),
           100);
      //return 150;
    })
    .linkStrength(function(l, i) {
    return 1;
    })
    .gravity(0.05)   // gravity+charge tweaked to ensure good 'grouped' view (e.g. green group not smack between blue&orange, ...
    .charge(-600)    // ... charge is important to turn single-linked groups to the outside
    .friction(0.1)   // friction adjusted to get dampened display: less bouncy bouncy ball [Swedish Chef, anyone?]
      .start();

  hullg.selectAll("path.hull").remove();
  hull = hullg.selectAll("path.hull")
      .data(convexHulls(net.nodes, getGroup, off))
    .enter().append("path")
      .attr("class", "hull")
      .attr("d", drawCluster)
      .style("fill", function(d) { return fill(d.group); })
      .on("click", function(d) {
      expand[d.group] = false; init();
    });

  link = linkg.selectAll("line.link").data(net.links, linkid);
  link.exit().remove();
  link.enter().append("line")
      .attr("class", function(d){ return "link "+d.source.id+" "+d.target.id;})
      .attr("x1", function(d) { return d.source.x; })
      .attr("y1", function(d) { return d.source.y; })
      .attr("x2", function(d) { return d.target.x; })
      .attr("y2", function(d) { return d.target.y; })
      .style("stroke-opacity", function(d) { return d.value; })
      .style("stroke-width", function(d) { return d.value || 1; });

  node = nodeg.selectAll("circle.node").data(net.nodes, nodeid);
  node.exit().remove();
  node.enter().append("circle")
      // if (d.size) -- d.size > 0 when d is a group node.
      .attr("class", function(d) { return "node" + (d.size?"":" leaf"); })
      .attr("r", function(d) { return d.size ? d.size + dr : dr+1; })
      .attr("cx", function(d) { return d.x; })
      .attr("cy", function(d) { return d.y; })
      .attr("id",function(d) { return d.id; })
      .style("fill", function(d) { return fill(d.group); })
      .on("mouseover",function(d){
          d3.selectAll("circle.leaf").attr("r", function(d) { return d.size ? d.size + dr : dr+1; })
          if($(this).attr("class").indexOf("leaf")!=-1 && d.author!='g'){
              showDetails(d);
              $(this).attr("r",10);
          }
      })
      .on("mouseout",function(d){
          if($(this).attr("class").indexOf("leaf")!=-1 && d.author!='g' && !d.selected){
              $("span").not(".note").text("");
              $(this).attr("r",function(d) { return d.size ? d.size + dr : dr+1; });
          }
      })
      .on("click", function(d,i) {
// console.log("node click", d, arguments, this, expand[d.group]);
        if($(this).attr("class").indexOf("leaf")!=-1 && d.author!='g'){
            showDetails(d);
            d.selected = true;
        }else{
            expand[d.group] = !expand[d.group];
        }
    init();
      })
      .on("contextmenu", function(d) {
        d3.event.preventDefault();
        if($(this).attr("class")=="node"){
            window.location.href = baseURL+"/report";
        }
      });

  node.call(force.drag);

  force.on("tick", function() {
    if (!hull.empty()) {
      hull.data(convexHulls(net.nodes, getGroup, off))
          .attr("d", drawCluster);
    }

    link.attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    node.attr("cx", function(d) { return d.x; })
        .attr("cy", function(d) { return d.y; });
  });
}

function editCurIssue(e){
    var myid = current_issue.id;
    myhtml = "<b>Address</b>: <input name=\"address\" value=\""+current_issue.address+"\"></input></br><b>Description</b>: <br><textarea name=\"description\">"+current_issue.description+"</textarea></br><b>Summary</b>: <input name=\"summary\" value=\""+current_issue.summary+"\"></input><br><button class=\"btn btn-default save-changes\" id=\"save-"+myid+"\">Save Changes</button>";
    $("div#currentIssue").html(myhtml);
    $("div#currentIssue").delegate("button.save-changes","click",function(){
        $.post(
          baseURL+'/issues/saveChanges/'+myid,
          {"id":myid,"address":$("input[name='address']").val(),"description":$(" textarea[name='description']").val(),"summary":$("input[name='summary']").val()},
          function(data) {
            if(data.status == 'success') {
                current_issue.address = data.address;
                current_issue.summary = data.summary;
                current_issue.username = data.username;
                current_issue.date_added = data.date_added;
                current_issue.sovled = data.solved;
                console.log(current_issue);
                myhtml = "<a class=\"btn btn-default linkbutton\" href=\"<?= BASE_URL ?>/report\">Report an Issue</a> Or you can right click a group node. <br/><b>Address</b>: <span>"+data.address+"</span> <br /><b>Summary</b>: <span>"+data.summary+"</span> <br /><b>Reporter</b>: <span>"+data.username+"</span> <br /><b>Date Added</b>: <span>"+data.date_added+"</span> <br /><a class=\"btn btn-default linkbutton\" href=" +baseURL+ "/issues/view/" + data.id + ">View</a><button class=\"btn btn-default report-solved\" id=\"solve-" +data.id+ "\">Report Solved</button><span class=\"note\"><em class=\"num-reports\">"+data.solved+"</em> reports solved</span><br/><button class=\"btn btn-default edit-issue\" id = \"edit\">Edit</button><button class = \"btn btn-default delete-issue\" id = \"delete\">Delete</button></td></tr>";
                $("div#currentIssue").html(myhtml);
                $("div#currentIssue").delegate('#edit',"click",editCurIssue);
                $("div#currentIssue").delegate('#delete',"click",deleteCurIssue);
                $('div#currentIssue').delegate('#report-solved','click',reportCurSolved);
            } else {
                if (data.status == "unauthorized"){
                    alert("Please login to report!")
                }
            }
          },
          "json"
        );
    });
}
function deleteCurIssue(e){
    if (confirm("Are you sure you want to delete this issue?")){
        var myid = current_issue.id;
        data.nodes.splice(data.nodes.indexOf(current_issue),1);
        net.nodes.splice(net.nodes.indexOf(current_issue),1);
        links = data.links.filter(function(l) {
            return l.source == current_issue || l.target == current_issue;
        });
        data.links.splice(data.links.indexOf(links[0]),1);
        init();
        $.post(
          baseURL+'/issues/delete/'+myid,
          function(data) {
            if(data.status == 'success') {
                $("span").not(".note").text("");
            } else {
                if (data.status == "unauthorized"){
                  alert("Please login to report!")
                }
            }
          },
          "json"
        );
    }
}
function reportCurSolved(e){
    var myid = current_issue.id;
    if ($(this).hasClass("reported")){
        $.post(
          baseURL+'/issues/reportUnSolved/'+myid,
          function(data) {
            if(data.status == 'success') {
                $("em#num-reports").text(data.solved);
                $("#report-solved").removeClass('reported');
                $("#report-solved").text("Report Solved")
            } else {
                if (data.status == "unauthorized"){
                    alert("Please login to report!")
                }
            }
          },
          "json"
        );
    }else{
        $.post(
          baseURL+'/issues/reportSolved/'+myid,
          function(data) {
            if(data.status == 'success') {
                $("em#num-reports").text(data.solved);
                $("#report-solved").addClass('reported');
                $("#report-solved").text("Undo Report")
            } else {
                if (data.status == "unauthorized"){
                  alert("Please login to report!")
                }
            }
          },
          "json"
        );
    }
}

function showDetails(d){
        $("span#address").text(d.address);
        $("span#summary").text(d.summary);
        $("span#author").text(d.author);
        $("span#date_added").text(d.date_added);
        $("em#num-reports").text(d.solved);
        $("a#view").attr("href",baseURL +"/issues/view/"+d.id);
        $("button#view").show();
        $("button#report-solved").show();
        $("iframe").show();
        $("iframe").attr("src",baseURL +"/issues/view/"+d.id)
        if (d.privilege != '1'){
            $("button#edit").show();
            $("button#delete").show();
        }else if (d.author == d.current_user) {
            $("button#edit").show();
            $("button#delete").hide();
        }else{
            $("button#edit").hide();
            $("button#delete").hide();
        }
        current_issue = d;
        $("#report-solved").text("Report Solved");
}
$("div#currentIssue").delegate('#edit',"click",editCurIssue);
$("div#currentIssue").delegate('#delete',"click",deleteCurIssue);
$('div#currentIssue').delegate('#report-solved','click',reportCurSolved);
