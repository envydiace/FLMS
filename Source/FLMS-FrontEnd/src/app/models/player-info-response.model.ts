import { ClubListPlayer } from "./club-list-player.model";

export interface ClubPlayerInfoResponse {
    messageCode: string;
    message: string;
    playerInfo: ClubListPlayer;
}

export class ClubPlayerInfoResponse implements ClubPlayerInfoResponse {
    constructor(
        messageCode: string,
        message: string,
        playerInfo: ClubListPlayer

    ) {
        this.messageCode = messageCode;
        this.message = message;
        this.playerInfo = playerInfo
    }
}
