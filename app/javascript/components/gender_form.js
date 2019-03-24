const selectGender = () => {
  const maleLabel = document.getElementById('male-label')
  const femaleLabel = document.getElementById('female-label')
  const genderOption = document.querySelectorAll('.gender-option');
  genderOption.forEach((option) => {
    option.addEventListener("click", () => {
      if (event.currentTarget.classList.contains('active')) {
        console.log(event.currentTarget.classList.contains('active'))

      } else {
        if (event.currentTarget == maleLabel) {
          event.currentTarget.classList.add('active');
          femaleLabel.classList.remove('active')
        } else {
          event.currentTarget.classList.add('active');
          maleLabel.classList.remove('active')
        }
      }
    });
  });
};


const clickOnGenderOption = () => {
  const genderOption = document.querySelectorAll('.gender-search');
  genderOption.forEach((option) => {
    option.addEventListener("click", () => {
      event.currentTarget.classList.toggle('active');
    });
  });
};

const selectAvailable = () => {
  const availableLabel = document.getElementById('available-label')
  const nonAvailableLabel = document.getElementById('non-available-label')
  const availableOption = document.querySelectorAll('.available-option');
  availableOption.forEach((option) => {
    option.addEventListener("click", () => {
      if (event.currentTarget.classList.contains('active')) {
        console.log(event.currentTarget.classList.contains('active'))

      } else {
        if (event.currentTarget == availableLabel) {
          event.currentTarget.classList.add('active');
          nonAvailableLabel.classList.remove('active')
        } else {
          event.currentTarget.classList.add('active');
          availableLabel.classList.remove('active')
        }
      }
    });
  });
};


export { selectAvailable };
export { clickOnGenderOption };
export { selectGender };
