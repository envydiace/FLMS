import { UserProfile } from './user-profile.model'

export interface UserProfileResponse {
    messageCode: string,
    message: string,
    userProfile: UserProfile
}

export class UserProfileResponse implements UserProfileResponse {
    constructor(
        messageCode: string,
        message: string,
        userProfile: UserProfile
    ) {
        this.messageCode = messageCode;
        this.message = message;
        this.userProfile = userProfile;
    }
}

