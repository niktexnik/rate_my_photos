import consumer from "./consumer";
consumer.subscriptions.create("NotificationsChannel", {
  received(data) {
    this.appendLine(data);
    this.openModal();
  },

  appendLine(data) {
    const html = this.createLine(data);
    const notify = document.querySelector('[data-notify]');
    const notifyContent = notify.querySelector('.content');

    notifyContent.innerHTML = html;
  },

  createLine(data) {
    return `
    <p class="speaker">${data["title"]}</p>
    <p class="body">${data["body"]}</p>
    `;
  },
  //=================MODAL================================

  openModal() {
    const notify = document.querySelector('[data-notify]');
    notify.classList.add('show');
    notify.classList.remove('hide');
  },

  if(notifyCloseBtn) {
      notifyCloseBtn.addEventListener('click', closeModal);
    },
  if(notify) {
      notify.addEventListener('click', (e) => {
        if (e.target === notify) {
          this.closeModal();
        }
      });
    }
});