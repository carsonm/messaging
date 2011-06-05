# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
$(document).bind 'keydown', (e) ->
  if e.keyCode == 8 || e.keyCode == 46
    conversation_id = $('.conversation_container ul .selected').attr('id').replace('conversation_li_', '')
    if confirm 'Are you sure you want to delete this message?'
      $('.conversation_container ul .selected').remove()
      $('.message_container').remove()
      $.ajax({
        type: "DELETE",
        url: "/conversations/destroy",
        data: "conversation_id=" + conversation_id
      });
$

`loadConversationThread = function(messagePath, conversationID) {
     console.log(messagePath);
     $('.conversation_thread').load(messagePath, function(){
       $('.message_container ul li:first .message_content').show();
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
   };`

`loadNewMessageForm = function(messagePath) {
     //$('.conversation_thread').load(messagePath, function(){
     //  $('.message_container ul li:first .message_content').show();
     //});
     $('.conversation_thread').load(messagePath, function(){
       //$('.message_container ul li:first .message_content').show();
     });
   };`