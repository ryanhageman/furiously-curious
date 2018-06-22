/* global $, Dropzone */

$(document).on('turbolinks:load', () => {
  Dropzone.autoDiscover = false
  let dropzoneElement = $('#post-images-dropzone')

  let addSuccessClass = element => {
    element.classList.add('dz-success')
  }

  let refreshImageChooser = () => {
    $.ajax({
      type: 'GET',
      url: '/accounts/post_images'
    })
  }

  dropzoneElement.dropzone({
    addRemoveLinks: true,
    dictRemoveFile: 'Clear',
    paramName: 'profile[post_images]',

    init() {
      refreshImageChooser()
    },

    success(file) {
      addSuccessClass(file.previewElement)
      refreshImageChooser()
    }
  })
})