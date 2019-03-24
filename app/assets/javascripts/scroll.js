const scrollLastMessageIntoView = () => {
  const messages = document.querySelectorAll('.message');
  const lastMessage = messages.last;

  if (lastMessage !== undefined) {
    lastMessage.scrollIntoView();
  }
}
