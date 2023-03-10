export interface Player {
    playerId: number,
    name: string,
    nickName: string,
    dob: Date,
    height: string,
    weight: string,
    address: string,
    phoneNumber: string,
    email: string,
    socialCont: string,
    clubId: number,
    number: number
}

export class Player implements Player {
    constructor(
        playerId: number,
        name: string,
        nickName: string,
        dob: Date,
        height: string,
        weight: string,
        address: string,
        phoneNumber: string,
        email: string,
        socialCont: string,
        clubId: number,
        number: number
    ) {
        this.playerId = playerId;
        this.name = name;
        this.nickName = nickName;
        this.dob = dob;
        this.height = height;
        this.weight = weight;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.socialCont = socialCont;
        this.clubId = clubId;
        this.number = number;
    }
}