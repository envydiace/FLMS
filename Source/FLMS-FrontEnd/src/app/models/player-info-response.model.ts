import { ClubListPlayer, PlayerbyClubMana } from "./club-list-player.model";

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

export interface PlayerInfobyClubManaResponse {
    messageCode: string;
    message: string;
    playerInfo: PlayerbyClubMana;
}

export class PlayerInfobyClubManaResponse implements PlayerInfobyClubManaResponse {
    constructor(
        messageCode: string,
        message: string,
        playerInfo: PlayerbyClubMana,
    ) {
        this.messageCode = messageCode;
        this.message = message;
        this.playerInfo = playerInfo;
    }
}

