<div id="content" style="margin-right:15%">
    <div id="vis" class="col-md-8"></div>
    <div id="currentIssue" class="col-md-4" style="font-size: 12px;">
        <a class="btn btn-default linkbutton" href="<?= BASE_URL ?>/report">Report an Issue</a> Or you can right click a group node. <br/>
        <h4>Issue Details:</h4>
        <b>Location Group:</b>: <span id="group_info"></span><br />
        <b>Address</b>: <span id="address"></span> <br />
        <b>Summary</b>: <span id="summary"></span> <br />
        <b>Reporter</b>: <span id="author"></span><br />
        <b>Last Modified</b>: <span id="date_added"></span> <br />
        <a class="btn btn-default linkbutton" id="view" style="display: none;">View</a>
        <button class="btn btn-default" id="report-solved" style="display: none;">Report Solved</button><span class="note"><em id="num-reports">0</em> reports solved</span><br/>
        <button class="btn btn-default" id="edit" style="display: none;">Edit</button>
        <button class = "btn btn-default" id="delete" style="display: none;">Delete</button>
    </div>
</div>
