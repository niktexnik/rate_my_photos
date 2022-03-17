// import consumer from "./consumer"

// consumer.subscriptions.create("NotificationsChannel", {
//   received(data) {
//     new Notification(data["title"], {body: data["body"]});
//   }
// });

import consumer from "./consumer";
consumer.subscriptions.create("NotificationsChannel", {
  received(data) {
    this.appendLine(data);
    this.openModal();
  },

  appendLine(data) {
    const html = this.createLine(data);
    //notify
    const notify = document.querySelector('.notify');
    const notifyContent = notify.querySelector('.content');
    const notifyCloseBtn = notify.querySelector('[data-close]');

    // const element = document.querySelector("[data-alert]");
    notifyContent.insertAdjacentHTML("beforeend", html);
    notifyContent.innerHTML = html;
  },

  createLine(data) {
    return `
    <span class="speaker">${data["title"]}</span>
    <span class="body">${data["body"]}</span>
    `;
  },
  //=================MODAL================================
  closeModal() {
    const notify = document.querySelector('.notify');
    notify.classList.add('hide');
    notify.classList.remove('show');
    document.body.style.overflow = '';
  },

  openModal() {
    const notify = document.querySelector('.notify');
    notify.classList.add('show');
    notify.classList.remove('hide');
    // document.body.style.overflow = 'hidden';
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