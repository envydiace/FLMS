

export interface ClubDetail {
    id: number;
    clubName: string;
    managerName: string;
    phone: number;
    facebook: string;
    email: string;
    win: number;
    lose: number;
    draw: number;
}



export class ClubDetail implements ClubDetail {
    constructor(
        id: number,
        clubName: string,
        managerName: string,
        phone: number,
        facebook: string,
        email: string,
        win: number,
        lose: number,
        draw: number
    ) {
        this.id = id;
        this.clubName = clubName;
        this.managerName = managerName;
        this.phone = phone;
        this.facebook = facebook;
        this.email = email;
        this.win = win;
        this.lose = lose;
        this.draw = draw;
    }
}


export interface AddClub {

    clubName: string,
    email: string,
    phoneNumber: number,
    socialCont: number,
    logo: string,
    kit: string
}

export class AddClub implements AddClub{
    constructor(
        clubName: string,
        email: string,
        phoneNumber: number,
        socialCont: number,
        logo: string,
        kit: string
    ){
        this.clubName = clubName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.socialCont = socialCont;
        this.logo = logo;
        this.kit = kit;
    }
}


export interface ClubListbyUser{
    clubId: number,
    userId: number,
    clubName: string
}

export class ClubListbyUser implements ClubListbyUser{
    constructor(
        clubId: number,
        userId: number,
        clubName: string
    ){
        this.clubId = clubId,
        this.userId = userId,
        this.clubName = clubName
    }
}


export interface GetUpdateClubDetail{
    clubName: string,
    logo: string,
    fanPage: string,
    email: string,
    phoneNumber: string
}

export class GetUpdateClubDetail implements GetUpdateClubDetail{
    constructor(
        clubName: string,
        logo: string,
        fanPage: string,
        email: string,
        phoneNumber: string
    ){
        this.clubName = clubName;
        this.logo = logo;
        this.fanPage = fanPage;
        this.email = email;
        this.phoneNumber = phoneNumber;
    }
}