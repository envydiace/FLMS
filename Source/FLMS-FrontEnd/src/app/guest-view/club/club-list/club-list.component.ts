import { Component, OnInit, ViewChild } from '@angular/core';
import { ClubService } from './../club.service';
import { ClubList } from 'src/app/models/club-list.model';
import { debounceTime, distinctUntilChanged, map, tap } from 'rxjs/operators';
import { PageEvent } from '@angular/material/paginator';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/auth/auth.service';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { combineLatest } from 'rxjs';
import { MatDialog } from '@angular/material/dialog';
import { PopUpSendInvitationComponent } from '../club-detail/pop-up-send-invitation/pop-up-send-invitation.component';
import { Title } from '@angular/platform-browser';

@Component({
  selector: 'app-club-list',
  templateUrl: './club-list.component.html',
  styleUrls: ['./club-list.component.scss']
})
export class ClubListComponent implements OnInit {
  // clubName: string = null;
  // managerName: string = null;
  clubList: ClubList = null;
  pageEvent: PageEvent;
  defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';
  userRole: string;
  filterForm: FormGroup;

  constructor(
    private clubService: ClubService,
    private formBuilder: FormBuilder,
    private titleService: Title,
    public dialog: MatDialog,
    private router: Router,
    private authService: AuthService,

  ) {
    this.createForm();
  }

  ngOnInit(): void {
    this.titleService.setTitle("List Clubs | FLMS");

    this.initDataSource();

    this.userRole = this.authService.getUserRole();

    this.onChangeFilter();
  }

  getControl(name: string) {
    return this.filterForm.get(name) as FormControl;
  }

  createForm() {
    this.filterForm = this.formBuilder.group({
      'search': [''],
    });
  }

  onChangeFilter() {

    this.filterForm.valueChanges.pipe(
      debounceTime(500), distinctUntilChanged()
    ).subscribe((values: any) => {
      let search = values.search;
      // let managerName = values.managerName;

      if (search == null) search = '';
      // if (managerName == null) managerName = '';

      this.clubService.getListClubFilter(search, 1, 8).pipe(
        map((clubList: ClubList) => this.clubList = clubList)
      ).subscribe()
    });
  }

  initDataSource() {
    this.clubService.findAll(1, 8).pipe(
      map((clubList: ClubList) => this.clubList = clubList)
    ).subscribe();
  }

  onPaginateChange(event: PageEvent) {
    let page = event.pageIndex;
    let size = event.pageSize;
    let search = this.getControl('search').value;
    // let managerName = this.getControl('managerName').value;
    if (search == null) {
      page = page + 1;
      this.clubService.findAll(page, size).pipe(
        map((clubList: ClubList) => this.clubList = clubList)
      ).subscribe();
    } else {
      page = page + 1;
      if (search == null || search == undefined) search.value = '';
      // if (managerName == null || managerName == undefined) managerName = '';
      this.clubService.getListClubFilter(search, page, size).pipe(
        map((clubList: ClubList) => this.clubList = clubList)
      ).subscribe()
    }

  }

  navigateToClubDetail(id: number) {
    this.router.navigate(['/club-info'], { queryParams: { clubId: id } });
  }

  openSendInvitation(clubId: number): void {
    const dialogRef = this.dialog.open(PopUpSendInvitationComponent, {
      width: '100%',
      data: { clubId: clubId }
    });

    dialogRef.afterClosed().subscribe(result => {
      
    });
  }
}
