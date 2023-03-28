import { Component, OnInit, ViewChild, AfterViewInit } from '@angular/core';
import { map, tap } from 'rxjs/operators';
import { ActivatedRoute } from '@angular/router';
import { ClubService } from '../../club.service';
import { ClubIncomingMatches } from '../../../../models/club-incoming-matches.model';
import { MatSort } from '@angular/material/sort';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';

@Component({
  selector: 'app-club-incoming-match',
  templateUrl: './club-incoming-match.component.html',
  styleUrls: ['./club-incoming-match.component.scss']
})
export class ClubIncomingMatchComponent implements OnInit, AfterViewInit {

  displayedColumns: string[] = ['Club', 'Against', 'League', 'Match Date', 'Time', 'Round', 'Stadium', 'Home/Away'];
  dataSource = new MatTableDataSource<ClubIncomingMatches>();
  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;

  constructor(
    private clubService: ClubService,
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
}
