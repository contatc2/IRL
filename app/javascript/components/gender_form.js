const clickOnGenderOption = () => {
  const genderOption = document.querySelector('.gender-option');
  genderOption.addEventListener("click", () => {
    event.currentTarget.classList.toggle('active');
  });
}


export { clickOnGenderOption };
