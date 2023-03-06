import { Component, OnInit } from '@angular/core';
import { ProfileService } from '../profile.service';
import { UserProfileResponse } from 'src/app/models/user-profile-response.model';
import { UserProfile } from 'src/app/models/user-profile.model';
import { map } from 'rxjs/operators';


@Component({
  selector: 'app-view-profile',
  templateUrl: './view-profile.component.html',
  styleUrls: ['./view-profile.component.scss']
})
export class ViewProfileComponent implements OnInit {
  userProfile: UserProfile = null;


  constructor(
    private profileService: ProfileService


  ) {

  }

  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource() {
    this.profileService.getuserprofile().pipe(
      map((res: UserProfileResponse) => this.userProfile = res.userProfile)
    ).subscribe();

  }

}
