import { ClubDetail} from './club-detail.model'

export interface AddClubResponse {
    messageCode: string;
    message: string;
    club: ClubDetail;
}

export class AddClubResponse implements AddClubResponse{
    constructor(
        messageCode: string,
        message: string,
        club: ClubDetail,
    ){
        this.messageCode = messageCode;
        this.message = message;
        this.club = club;
    }

}