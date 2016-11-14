<?php

// format events for recent activity feeds
function formatEvent($event=null) {
  if($event==null)
    return null;

  // what type of event is it?
  $eventType = EventType::loadById($event->get('event_type_id'));
  $eventTypeName = $eventType->get('name');

  $formattedEvent = '';
  switch($eventTypeName) {
    case 'report_issue':
      $user1name = User::getUsernameById($event->get('user_1_id'));
      $issue = Issue::loadById($event->get('issue_id'));
      $summary = $issue->get('summary');
      $address = $issue->get('address');
      $date = date("m-j-y g:i a", strtotime($issue->get('date_added')));
      $issueURL = BASE_URL.'/issues/view/'.$issue->get('id');
      $date = date("m-j-y g:i a", strtotime($event->get('date_created')));

      if($user1name==$_SESSION['user']){
          $user1name = 'You';
      }
      
      $formattedEvent = sprintf('%s reported an issue: <a href="%s">%s</a> at <b>address:</b> %s on <b>date:</b> %s.',
        $user1name,
        $issueURL,
        $summary,
        $address,
        $date
        );
      break;

    case 'follow_user':
      $user1name = User::getUsernameById($event->get('user_1_id'));
      if($user1name==$_SESSION['user']){
          $user1name = 'You';
      }
      $user2name = User::getUsernameById($event->get('user_2_id'));
      if($user2name==$_SESSION['user']){
          $user2name = 'you';
      }
      $date = date("m-j-y g:i a", strtotime($event->get('date_created')));

      $formattedEvent = sprintf("%s followed %s on %s.",
        $user1name,
        $user2name,
        $date
        );
      break;

    default:
      $formattedEvent = 'Unrecognized event type.';
  }
  return $formattedEvent;
}
