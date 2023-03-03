import { playerInClubList } from "./club-list-player.model";

export interface ListPLayerResponse{
    messageCode:string;
    message:string;
    players:playerInClubList[];
}

export class ListPLayerResponse implements ListPLayerResponse{
    constructor(
        messageCode: string,
        message: string,
        players: playerInClubList[],
    ){
        this.messageCode = messageCode;
        this.message = message;
        this.players = players;
    }
}
