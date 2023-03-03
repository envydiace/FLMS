import { Component, OnInit } from '@angular/core';
import { map } from 'rxjs/operators';
import { AuthService } from 'src/app/auth/auth.service';
import { User } from 'src/app/models/user';
import { UserProfileResponse } from 'src/app/models/user-profile-response.model';
import { UserProfile } from 'src/app/models/user-profile.model';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.scss']
})
export class NavbarComponent implements OnInit {
  user: UserProfile;

  constructor(
    private authService: AuthService
  ) { }

  ngOnInit(): void {
    if(this.authService.userValue != null) {
      this.getCurrentUser();
    }
    
  }

  getCurrentUser() {
    this.authService.getCurrentUser().pipe(
      map((res: UserProfileResponse) => this.user = res.userProfile)
    ).subscribe();
  }

  logout(){
    this.authService.logout();
  }
}
