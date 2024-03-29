import { Component, OnInit, ViewChild, AfterViewInit } from '@angular/core';
import { map, tap } from 'rxjs/operators';
import { ActivatedRoute, Router } from '@angular/router';
import { ClubService } from './../../club/club.service';
import { ClubIncomingMatches } from '../../../models/club-incoming-matches.model';
import { MatSort } from '@angular/material/sort';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';

@Component({
  selector: 'app-club-incoming-match',
  templateUrl: './club-incoming-match.component.html',
  styleUrls: ['./club-incoming-match.component.scss']
})
export class ClubIncomingMatchComponent implements OnInit, AfterViewInit {

  displayedColumns: string[] = ['clubName', 'against', 'leagueName', 'matchDate', 'matchTime', 'round', 'stadium', 'ha'];
  dataSource = new MatTableDataSource<ClubIncomingMatches>();
  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;

  constructor(
    private clubService: ClubService,
    private router: Router
    ) {
  }

  ngOnInit(): void {
    this.initDataSource();
    this.dataSource.sort = this.sort;
    this.dataSource.paginator = this.paginator;
  }
  
  ngAfterViewInit() {
    this.dataSource.paginator = this.paginator;
    this.dataSource.sort = this.sort;
  }

  initDataSource() {
    this.getIncomingmatches();
  }

  getIncomingmatches() {
    this.clubService.getIncomingMatches().pipe
      (map((res: ClubIncomingMatches[]) => this.dataSource.data = res)
      ).subscribe();
  }

  navigateToEditLineUp(squadId: any) {
    this.router.navigate(['manager/edit-line-up'], { queryParams: {squadId : squadId}});
  }
}
