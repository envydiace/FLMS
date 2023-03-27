import { CdkDragDrop, moveItemInArray, transferArrayItem } from '@angular/cdk/drag-drop';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { map } from 'rxjs/operators';
import { ClubListByLeagueResponse } from 'src/app/models/club-list-by-league-response.model';
import { ClubListByLeague } from 'src/app/models/club-list-by-league.model';
import { LeagueTree, TreeNode } from 'src/app/models/league-tree.model';
import { LeagueService } from '../../league.service';

export class Nodes {
  node: TreeNode[];
}

export class Tree {
  rowNodes: TreeNode[];
}

@Component({
  selector: 'app-league-settings',
  templateUrl: './league-settings.component.html',
  styleUrls: ['./league-settings.component.scss']
})
export class LeagueSettingsComponent implements OnInit {
  listClubByLeague: ClubListByLeague[] = [];
  leagueId: number;
  imgSrc: string = './../../../../../assets/image/clubDefaultLogo.png';
  leagueTree: LeagueTree;
  treeNode: Tree[] = [];

  timePeriods = [
    'Bronze age',
    'Iron age',
    'Middle ages',
    'Early modern period',
    'Long nineteenth century'
  ];

  constructor(
    private route: ActivatedRoute,
    private leagueService: LeagueService,
  ) {
    this.route.queryParams.subscribe(params => {
      this.leagueId = params['leagueId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();

  }

  initDataSource() {
    this.findClubByLeague();
    this.getLeagueTree();
  }

  findClubByLeague() {
    this.leagueService.findClubByLeague(this.leagueId + '', '').pipe(
      map((listClubByLeague: ClubListByLeagueResponse) => this.listClubByLeague = listClubByLeague.clubs)
    ).subscribe();
  }

  getLeagueTree() {
    this.leagueService.getLeagueTree(this.leagueId).pipe(
      map((res: LeagueTree) => this.leagueTree = res)
    ).subscribe(() => {
      this.bindNodeIntoTree();
    });
  }

  drop(event: CdkDragDrop<string[]>) {
    if (event.previousContainer === event.container) {
      moveItemInArray(event.container.data, event.previousIndex, event.currentIndex);

    } else {
      transferArrayItem(event.previousContainer.data,
        event.container.data,
        event.previousIndex,
        event.currentIndex);
    }
  }

  bindNodeIntoTree() {
    const treeNodeFromDB = this.leagueTree;

    if (treeNodeFromDB != null && treeNodeFromDB != undefined) {
      for (let index = 1; index <= treeNodeFromDB.treeHeight; index++) {
        const nodes: TreeNode[] = treeNodeFromDB.listNode.filter(n => n.deep == index);

        let rowNode: Tree = new Tree();
        rowNode.rowNodes = nodes;

        this.treeNode.push(rowNode);
      }
    }

    this.treeNode.forEach(element => {
      console.log('Tree Nodes:' + element.rowNodes.length);

    });
  }
}
