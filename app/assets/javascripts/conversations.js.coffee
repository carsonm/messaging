# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

`loadConversationThread = function(messagePath, conversationID) {
     $('.conversation_thread').load(messagePath, function(){
       $('#message_content_' + conversationID).show();
     });
     $('.conversation_container li').addClass('not_selected');
     $('.li_shadow_1').removeClass();
     $('.li_shadow_2').removeClass();
     $('.li_background').removeClass();
     $('#' + conversationID).toggleClass('not_selected');
     $('#' + conversationID + 'li_shadow_1').toggleClass('li_shadow_1');
     $('#' + conversationID + 'li_shadow_2').toggleClass('li_shadow_2');
     $('#' + conversationID + 'li_background').toggleClass('li_background');



   };`
