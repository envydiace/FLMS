import { CdkDragDrop, moveItemInArray, transferArrayItem } from '@angular/cdk/drag-drop';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { first, map } from 'rxjs/operators';
import { ClubListByLeagueResponse } from 'src/app/models/club-list-by-league-response.model';
import { ClubListByLeague } from 'src/app/models/club-list-by-league.model';
import { CoupleNode, LeagueTree, TreeNode, UpdateNode, UpdateTreeModel } from 'src/app/models/league-tree.model';
import { LeagueService } from '../../league.service';
import { NgttTournament, NgttRound } from 'ng-tournament-tree';
import { CommonService } from 'src/app/common/common/common.service';

@Component({
  selector: 'app-league-settings',
  templateUrl: './league-settings.component.html',
  styleUrls: ['./league-settings.component.scss']
})
export class LeagueSettingsComponent implements OnInit {
  leagueId: number;
  imgSrc: string = './../../../../../assets/image/clubDefaultLogo.png';
  leagueTree: LeagueTree;
  listAvailNode: TreeNode[];
  winner: TreeNode;

  public singleEliminationTournament: NgttTournament;

  constructor(
    private route: ActivatedRoute,
    private leagueService: LeagueService,
    private commonService: CommonService,
  ) {
    this.route.queryParams.subscribe(params => {
      this.leagueId = params['leagueId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource() {
    this.getLeagueTree();
  }

  getLeagueTree() {
    this.leagueService.getLeagueTree(this.leagueId).pipe(
      map((res: LeagueTree) => {
        this.leagueTree = res;
        this.listAvailNode = res.listAvailNode;
        if (res != null && res != undefined) this.bindNodeIntoTree(res);
      })
    ).subscribe(() => {

    });
  }

  drop(event: CdkDragDrop<TreeNode[]>) {
    if (event.previousContainer === event.container) {
      moveItemInArray(event.container.data, event.previousIndex, event.currentIndex);

    } else {
      const previousPosition = event.previousContainer.data[event.previousIndex];
      const currentPosition = event.container.data[event.currentIndex];

      if (previousPosition != undefined && currentPosition != undefined && currentPosition.hasChild == false) {
        //swap nodeId befor change
        let oldNodeId = event.previousContainer.data[event.previousIndex].nodeId;
        event.previousContainer.data[event.previousIndex].nodeId = event.container.data[event.currentIndex].nodeId;
        event.container.data[event.currentIndex].nodeId = oldNodeId;

        let oldtarget = event.previousContainer.data[event.previousIndex];
        event.previousContainer.data[event.previousIndex] = event.container.data[event.currentIndex];
        event.container.data[event.currentIndex] = oldtarget;
      }

      // transferArrayItem(event.previousContainer.data,
      //   event.container.data,
      //   event.previousIndex,
      //   event.currentIndex);
    }
  }

  bindNodeIntoTree(res: LeagueTree) {
    const leagueTree = res;
    const rounds: NgttRound[] = [];
    for (let index = leagueTree.treeHeight; index >= 1; index--) {
      let matches = leagueTree.listNode.filter(n => n.deep == index);

      let round: NgttRound;
      if (index == 2) {
        round = {
          type: 'Final',
          matches
        };
      } else if (index == 1) {
        this.winner = matches[0].participation[0];
      } else {
        round = {
          type: 'Winnerbracket',
          matches
        };
      }

      const parentRound = leagueTree.listNode.filter(n => n.deep == index - 1);
      if (matches.length < parentRound.length * 2) {
        const emptyMatch: CoupleNode = {
          deep: index,
          parentId: null,
          participation: null
        }
        for (let i = matches.length + 1; i <= parentRound.length * 2; i++) {

          round.matches.push(emptyMatch);
        }
      }


      if (round != undefined && round != null) rounds.push(round);
    }
    this.singleEliminationTournament = {
      rounds
    };
  }

  onSubmit() {
    const CoupleNodes: CoupleNode[] = [];
    const nodes: TreeNode[] = [];
    let listNode: UpdateNode[] = [];

    nodes.push(this.winner);
    for (let index = this.leagueTree.treeHeight - 2; index >= 0; index--) {

      const nodeRound = this.singleEliminationTournament.rounds[index].matches;

      if (this.singleEliminationTournament.rounds[index].type == 'Final') {
        CoupleNodes.push(nodeRound[0]);
      } else {
        CoupleNodes.push(...nodeRound);

      }
    }

    CoupleNodes.forEach(element => {
      if (element.participation != null) nodes.push(...element.participation);
    });

    nodes.forEach(node => {
      if (node.hasChild == false) {
        let tempNode = {
          nodeId: node.nodeId,
          clubId: node.clubBasicInfo != null ? node.clubBasicInfo.clubId : null
        }
        listNode.push(tempNode);
      }
    });

    const tree: UpdateTreeModel = {
      leagueId: this.leagueId,
      listNode: listNode
    }

    this.leagueService.updateLeagueTree(tree)
      .pipe(first())
      .subscribe({
        next: () => {
          this.commonService.sendMessage('Update success!', 'success')
        },
        error: error => {
          this.commonService.sendMessage(error.error.message, 'fail')
        }
      });
  }
}
