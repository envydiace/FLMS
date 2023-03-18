

export interface ClubListByLeague {
    leagueId: number,
    clubId: number,
    confirmed: boolean,
    clubName: string,
}

export class ClubListByLeague implements ClubListByLeague{
    constructor(
        leagueId: number,
        clubId: number,
        confirmed: boolean,
        clubName: string,
    ){
        this.leagueId = leagueId;
        this.clubId = clubId ;
        this.confirmed = confirmed;
        this.clubName = clubName;
    }
}
