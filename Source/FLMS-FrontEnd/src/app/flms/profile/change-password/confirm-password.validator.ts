import { AbstractControl, FormGroup } from "@angular/forms";
export function ConfirmPasswordValidator(newpassword: string, repassword: string) {
  return (formGroup: FormGroup) => {
    let newpass = formGroup.controls[newpassword];
    let repass = formGroup.controls[repassword]
    if (
      repass.errors &&
      !repass.errors.confirmPasswordValidator
    ) {
      return;
    }
    if (newpass.value !== repass.value) {
      repass.setErrors({ confirmPasswordValidator: true });
    } else {
      repass.setErrors(null);
    }
  };
}

