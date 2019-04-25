const scrollLastMessageIntoView = () => {
  const messages = document.querySelectorAll('.message');
  const last_index = messages.length - 1 ;
  const lastMessage = messages.item( last_index );

  if (lastMessage !== null) {
    lastMessage.scrollIntoView();
  }
}
