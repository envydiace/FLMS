import { ClubListPlayer } from "./club-list-player.model";

export interface ClubListPlayerResponse{
    messageCode:string;
    message:string;
    players:ClubListPlayer[];
}

export class ClubListPlayerResponse implements ClubListPlayerResponse{
    constructor(
        messageCode: string,
        message: string,
        players: ClubListPlayer[]
    ){
        this.messageCode = messageCode;
        this.message = message;
        this.players = players;
    }
}
