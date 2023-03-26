export interface UserProfile {
    email: string,
    fullName: string,
    address: string,
    phone: string,
    avatar: string
}

export class UserProfile implements UserProfile {
    constructor(
        email: string,
        fullName: string,
        address: string,
        phone: string,
        avatar: string
    ) {
        this.email = email;
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.avatar = avatar;
    }
}