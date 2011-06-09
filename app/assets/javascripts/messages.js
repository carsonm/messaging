$(function() {
    $('#hidden_message').bind('click', function(event) {
      if ($('#hidden_message').attr("alt") === "Show Hidden Messages") {
        $('.message_container .hidden_message_li').show();
        return $('#hidden_message').attr("alt", "Hide Hidden Messages");
      } else {
        $('.message_container .hidden_message_li').hide();
        return $('#hidden_message').attr("alt", "Show Hidden Messages");
      }
    });
    $('#expand_messages').bind('click', function(event) {
      return $('.message_content').show();
    });
    $('#collapse_messages').bind('click', function(event) {
      return $('.message_content').hide();
    });
    return $(document).bind('keydown', function(e) {
      var conversation_id;
      if ((e.keyCode === 8 || e.keyCode === 46) && !$('#message_content').is(":focus")) {
        conversation_id = $('.conversation_container ul .selected').attr('id').replace('conversation_li_', '');
        if (confirm('Are you sure you want to delete this message?')) {
          $('.conversation_container ul .selected').remove();
          $('.message_container').remove();
          return $.ajax({
            type: "DELETE",
            url: "/conversations/destroy",
            data: "conversation_id=" + conversation_id
          });
        }
      }
    });
  });
  deleteConversation = function() {
     if($(".conversation_container .selected").length != 0 ){
       conversation_id = $('.conversation_container .selected').attr('id').replace('conversation_li_', '')
       if(confirm('Are you sure you want to delete this message?')){
          $('.conversation_container ul .selected').remove();
          $('.message_container').remove();
          $.ajax({
            type: "DELETE",
            url: "/conversations/destroy",
            data: "conversation_id=" + conversation_id
          });
        }
     }
   };;
  unDeleteConversation = function() {
    if($(".conversation_container .selected").length != 0 ){
     conversation_id = $('.conversation_container .selected').attr('id').replace('conversation_li_', '')
      $('.conversation_container ul .selected').remove();
      $('.message_container').remove();
      $.ajax({
        type: "DELETE",
        url: "/conversations/restore",
        data: "conversation_id=" + conversation_id
      });
    }
   };;
  loadConversationThread = function(messagePath, conversationID, starred, messageIDs, searchTerm) {
     $('.conversation_thread').load(messagePath + '?starred=' + starred + '&messageIDs=' + messageIDs, function(){
       if(starred=="true"){
         $('.message_container ul .message_li .message_content').show();
         $('.message_content.hidden').hide();
       }
       else if(messageIDs.length > 0){
         for(x in messageIDs){
           $('#message_content_' + messageIDs[x]).show();
         }
       }
       else{
         $('.message_container ul .message_li:first .message_content').show();
       }
       if(searchTerm != ''){
         $('li').highlight(searchTerm);
       }
     });

     $('.conversation_container li').removeClass('selected');
     $('.conversation_container li').addClass('not_selected');

     $('.li_shadow_1').removeClass();
     $('.li_shadow_2').removeClass();
     $('.li_background').removeClass();
     $('#conversation_li_' + conversationID).removeClass('not_selected');
     $('#conversation_li_' + conversationID).addClass('selected');
     $('#' + conversationID + 'li_shadow_1').toggleClass('li_shadow_1');
     $('#' + conversationID + 'li_shadow_2').toggleClass('li_shadow_2');
     $('#' + conversationID + 'li_background').toggleClass('li_background');
   };;
  loadNewMessageForm = function(messagePath) {
     //$('.conversation_thread').load(messagePath, function(){
     //  $('.message_container ul li:first .message_content').show();
     //});
     $('.conversation_thread').load(messagePath, function(){
       //$('.message_container ul li:first .message_content').show();
     });
   };;
  starIt = function(messageID) {
     $('#message_li_' + messageID + ' #message_header #star img').attr('src', 'assets/messaging_starred.png')
     $.ajax({
          type: "POST",
          url: "/messages/star",
          data: "id=" + messageID
        });
   };;
  unStarIt = function(messageID) {
     $('#message_li_' + messageID + ' #message_header #star img').attr('src', 'assets/messaging_unstarred.png')
     $.ajax({
          type: "POST",
          url: "/messages/unstar",
          data: "id=" + messageID
        });
   };