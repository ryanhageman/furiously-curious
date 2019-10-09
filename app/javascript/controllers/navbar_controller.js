import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['visibility']

  toggle() {
    this.visibilityTarget.classList.remove('initial-load')
    this.visibilityTarget.classList.toggle('is-open')
    this.visibilityTarget.classList.toggle('is-closed')
  }
}
