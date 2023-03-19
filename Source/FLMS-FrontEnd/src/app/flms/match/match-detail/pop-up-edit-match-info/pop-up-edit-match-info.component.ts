import { Component, Inject, OnInit } from '@angular/core';

import { ActivatedRoute } from '@angular/router';
import { map } from 'rxjs/operators';
import { MatchDetailResponse } from 'src/app/models/match-detail-response.model';
import { MatchDetail } from 'src/app/models/match-detail.model';
import { MatchService } from '../../match.service';
import { MatDialogRef, MAT_DIALOG_DATA, MatDialog } from '@angular/material/dialog';
@Component({
  selector: 'app-pop-up-edit-match-info',
  templateUrl: './pop-up-edit-match-info.component.html',
  styleUrls: ['./pop-up-edit-match-info.component.scss']
})
export class PopUpEditMatchInfoComponent implements OnInit {
  matchDetail: MatchDetail = null;
 


  constructor(
    private MatchService: MatchService,
    private route: ActivatedRoute,
    public dialogRe: MatDialog,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      matchId: number;
    }
  ) {
   
   }

  ngOnInit(): void {
    this.initDataSource();

  }


  initDataSource() {
    this.getMatchInfoById(this.data.matchId);
  }

  getMatchInfoById(matchId: number) {
    this.MatchService.getMatchInfoById(matchId).pipe(map ((res: MatchDetailResponse) => this.matchDetail = res.match)).subscribe();
  }
}
