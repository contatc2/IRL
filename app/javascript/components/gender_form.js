const clickOnGenderOption = () => {
  const genderOption = document.querySelectorAll('.gender-option');
  genderOption.forEach((option) => {
    option.addEventListener("click", () => {
      event.currentTarget.classList.toggle('active');
    });
  });
};


export { clickOnGenderOption };
