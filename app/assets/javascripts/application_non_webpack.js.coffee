# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#= require jquery
#= require jquery_ujs
#= require bsa
#= require analytics
#= require likes
#= require textarea_with_file_drop_support

$ ->
  $.ajaxSetup error: (xhr, status, err) ->
    promptUserSignInOn401(xhr)
    return

  $('textarea').on 'input', resizeTextAreaForNewInput
  $('.js-popout').click(openPopout)

  unless document.current_user_id?
    setUserId()

  document.current_user_likes = new Likes(document.current_user_id)

@setUserId = ->
  userId = $("meta[property='current_user:id']").attr("content")
  document.current_user_id = userId if userId?

@promptUserSignInOn401 = (xhr) ->
  if xhr.status == 401
    window.location.replace('/signin')
  return

@resizeTextAreaForNewInput = ->
  textarea_to_resize = this
  textarea_new_hight = textarea_to_resize.scrollHeight
  textarea_to_resize.style.cssText = 'height:auto;'
  textarea_to_resize.style.cssText = 'height:' + textarea_new_hight + 'px'

openPopout = ->
  w = window.open(@href, @target || "_blank", 'menubar=no,toolbar=no,location=no,directories=no,status=no,scrollbars=no,resizable=no,dependent,width=400,height=600,left=0,top=0')
  return !w
