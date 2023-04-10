

export interface ClubListByLeague {
    leagueId: number,
    clubId: number,
    confirmed: boolean,
    clubName: string,
    logo: string,
}

export class ClubListByLeague implements ClubListByLeague {
    constructor(
        leagueId: number,
        clubId: number,
        confirmed: boolean,
        clubName: string,
        logo: string,

    ) {
        this.leagueId = leagueId;
        this.clubId = clubId;
        this.confirmed = confirmed;
        this.clubName = clubName;
        this.logo = logo;
    }
}
