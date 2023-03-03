export interface playerInClub {
    playerId: number;
    clubId: number;
    number: number;
}


export class playerInClub implements playerInClub {

    constructor(
        playerId: number,
        clubId: number,
        number: number,
    ) {
        this.playerId = playerId;
        this.clubId = clubId;
        this.number = number;
     }
}


