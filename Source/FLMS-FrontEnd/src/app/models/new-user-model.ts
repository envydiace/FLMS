export interface UserRegister {
    email: string;
    password: string;
    confirmPassword: string;
    fullName: string;
    phone: string;
    address: string;
    role: string;
}

export class UserRegister implements UserRegister {
    constructor(
        email: string,
        password: string,
        confirmPassword: string,
        fullName: string,
        phone: string,
        address: string,
        role: string
    ) {
        this.email = email;
        this.password = password;
        this.confirmPassword = confirmPassword;
        this.fullName = fullName;
        this.phone = phone;
        this.address = address;
        this.role = role;
    }
}