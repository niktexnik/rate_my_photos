import consumer from "./consumer"

consumer.subscriptions.create("NotificationsChannel", {
  received(data) {
    new Notification(data["title"], data["body"]);
  }
});

// import consumer from "./consumer";
//   consumer.subscriptions.create("NotificationsChannel", {
//   received(data) {
//     console.log('Hello from received')
//     this.appendLine(data)
//   },

//   appendLine(data) {
//     console.log('Hello from appendData')
//     const html = this.createLine(data)
//     const element = document.querySelector("[data-alert]")
//     element.insertAdjacentHTML("beforeend", html)
//   },

//   createLine(data) {
//     console.log('Hello from createLine')
//     return `
//       <article class="chat-line">
//         <span class="speaker">${data["title"]}</span>
//         <span class="body">${data["body"]}</span>
//       </article>
//     `
//   }
// })
// consumer.notifications = consumer.subscriptions.create("NotificationsChannel", {  
//   received: function(data) {
//     return $('#notifications').html(this.renderMessage(data));
//   },
//   connected:function(){
//   },
//   renderMessage: function(data) {
//     return data;
//   }
// });

// let comment = {
//   connected() {console.log('Connect');},
//   disconnected() {console.log('Disconnect');},
//   received(data) {
//     console.log('received');
//     console.log(data);
//     if (Notification.permission === 'granted') {
//       var title = 'Push Notification';
//       var body = data;
//       var options = { body: body };
//       new Notification(title, options);
//     }
//   }
// }
// Notification.requestPermission().then(function (result) {})
// consumer.subscriptions.create('NotificationsChannel', comment)

// consumer.subscriptions.create("NotificationChannel", {
//   connected() {console.log('Connect')},
//   disconnected() {console.log('Disconnect');},
//   received(data) {
//     console.log('received');
//     console.log(data);
//   if (Notification.permission === 'granted') {
//       var title = 'Push Notification';
//       var body = data;
//       var options = { body: body };
//       new Notification(title, options);
//     }
//   }
// });

// if (Notification.permission == 'granted') {
//   navigator.serviceWorker.getRegistration().then(function(reg) {
//     var options = {
//       body: 'Here is a notification body!',
//       icon: 'images/example.png',
//       vibrate: [100, 50, 100],
//       data: {
//         dateOfArrival: Date.now(),
//         primaryKey: 1
//       }
//     };
//     reg.showNotification('Hello world!', options);
//   });
// }