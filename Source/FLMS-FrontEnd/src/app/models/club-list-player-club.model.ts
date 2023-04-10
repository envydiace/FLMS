export interface ClubListPlayerClub {
    playerId: number;
    clubId: number;
    number: number;
    clubName: string;
    clubLogo: string;
}


export class ClubListPlayerClub implements ClubListPlayerClub {

    constructor(
        playerId: number,
        clubId: number,
        number: number,
        clubName: string,
        clubLogo: string,
    ) {
        this.playerId = playerId;
        this.clubId = clubId;
        this.number = number;
        this.clubName = clubName;
        this.clubLogo = clubLogo;
    }
}



