# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

`loadConversationThread = function(messagePath, conversationID) {
     $('.conversation_thread').load(messagePath);
     $('.selected').removeClass();
     $('#' + conversationID).toggleClass('selected');
     $('#' + conversationID + ' #li_shadow_1').toggleClass('li_shadow_1')
     $('#' + conversationID + ' #li_shadow_1').toggleClass('li_shadow_2')
     $('#' + conversationID + ' #li_shadow_1').toggleClass('li_background')
   };`
