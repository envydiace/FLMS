export interface UserProfile {
    email: string,
    fullName: string,
    address: string,
    phone: string,
    avatar: string,
    role: string
}

export class UserProfile implements UserProfile {
    constructor(
        email: string,
        fullName: string,
        address: string,
        phone: string,
        avatar: string,
        role: string
    ) {
        this.email = email;
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.avatar = avatar;
        this.role = role;
    }
}