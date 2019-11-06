import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['imageList', 'toggleButton']

  toggleImagePicker() {
    this.imageListTarget.classList.toggle('is-open')
    this._toggleImagePickerMessage()
  }

  _toggleImagePickerMessage() {
    var message = 'Add An Image'
    if (this.imageListTarget.classList.contains('is-open')) {
      message = 'Hide Images'
    }
    this.toggleButtonTarget.innerHTML = message
  }
}
