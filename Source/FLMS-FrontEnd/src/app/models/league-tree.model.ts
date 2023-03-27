export interface LeagueTree {
    listNode: TreeNode[];
    listAvailNode: TreeNode[];
    leagueId: number;
    canEdit: boolean;
    numberOfNode: number;
    treeHeight: number;
}

export class LeagueTree implements LeagueTree {
    constructor(
        listNode: TreeNode[],
        listAvailNode: TreeNode[],
        leagueId: number,
        canEdit: boolean,
        numberOfNode: number,
        treeHeight: number
    ) {
        this.listNode = listNode;
        this.listAvailNode = listAvailNode;
        this.leagueId = leagueId;
        this.canEdit = canEdit;
        this.numberOfNode = numberOfNode;
        this.treeHeight = treeHeight;
    }
}

export interface TreeNode {
    nodeId: number;
    deep: number;
    parentId: number;
    leftId: number;
    rightId: number;
    hasChild: boolean;
    score: number;
    clubBasicInfo: ClubBasicInfo;
}

export class TreeNode implements TreeNode {
    constructor(
        nodeId: number,
        deep: number,
        parentId: number,
        leftId: number,
        rightId: number,
        hasChild: boolean,
        score: number,
        clubBasicInfo: ClubBasicInfo
    ) {
        this.nodeId = nodeId;
        this.deep = deep;
        this.parentId = parentId;
        this.leftId = leftId;
        this.rightId = rightId;
        this.hasChild = hasChild;
        this.score = score;
        this.clubBasicInfo = clubBasicInfo;
    }
}

export interface ClubBasicInfo {
    clubId: number;
    clubName: string;
    logo: string;
}

export class ClubBasicInfo implements ClubBasicInfo {
    constructor(
        clubId: number,
        clubName: string,
        logo: string
    ) {
        this.clubId = clubId;
        this.clubName = clubName;
        this.logo = logo;
    }
}

