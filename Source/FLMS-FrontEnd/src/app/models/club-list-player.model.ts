import { ClubListPlayerClub } from './club-list-player-club.model';

export interface ClubListPlayer {
    playerId: number;
    name: string;
    nickName: string;
    dob: Date;
    height: string;
    weight: string;
    address: string;
    phoneNumber: string;
    email: string;
    socialCont: string;
    playerClubs: ClubListPlayerClub[];
    goal: number;
    assistant: number;
    redCard: number;
    yellowCard: number;
    avatar: string;
}

export class ClubListPlayer implements ClubListPlayer {
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
        playerClubs: ClubListPlayerClub[],
        goal: number,
        assistant: number,
        redCard: number,
        yellowCard: number,
        avatar: string,
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
        this.playerClubs = playerClubs;
        this.goal = goal;
        this.assistant = assistant;
        this.redCard = redCard;
        this.yellowCard = yellowCard;
        this.avatar = avatar;
    }
}


export interface PlayerbyClubMana {
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
    clubName: string,
    clubLogo: string,
    clubId: number,
    number: number,
    goal: number,
    assistant: number,
    redCard: number,
    yellowCard: number,
    avatar: string
}

export class PlayerbyClubMana implements PlayerbyClubMana {
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
        clubName: string,
        clubLogo: string,
        clubId: number,
        number: number,
        goal: number,
        assistant: number,
        redCard: number,
        yellowCard: number,
        avatar: string
    ) {
        this.playerId = playerId,
            this.name = name,
            this.nickName = nickName,
            this.dob = dob,
            this.height = height,
            this.weight = weight,
            this.address = address,
            this.phoneNumber = phoneNumber,
            this.email = email,
            this.socialCont = socialCont,
            this.clubName = clubName,
            this.clubLogo = clubLogo,
            this.clubId = clubId,
            this.number = number,
            this.goal = goal,
            this.assistant = assistant,
            this.redCard = redCard,
            this.yellowCard = yellowCard,
            this.avatar = avatar
    }
}

export interface getListPlayerJoinMatch{
    playerId: number,
    name: string,
    avatar: string,
}

export class getListPlayerJoinMatch implements getListPlayerJoinMatch{
    constructor(
        playerId: number,
        name: string,
        avatar: string,
    ){
        this.playerId = playerId;
        this.name = name;
        this.avatar = avatar;
    }
}


