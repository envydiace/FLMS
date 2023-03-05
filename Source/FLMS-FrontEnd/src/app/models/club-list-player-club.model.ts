export interface ClubListPlayerClub {
    playerId: number;
    clubId: number;
    number: number;
}


export class ClubListPlayerClub implements ClubListPlayerClub {

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


