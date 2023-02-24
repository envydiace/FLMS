import { Component, OnInit } from '@angular/core';
import { HomepageService }  from './homepage.service';
import { first } from 'rxjs/operators';

@Component({
  selector: 'app-homepage',
  templateUrl: './homepage.component.html',
  styleUrls: ['./homepage.component.scss']
})
export class HomepageComponent implements OnInit {
  clubs = null;

  constructor(
    private homeService: HomepageService
  ) { }

  ngOnInit(): void {
    this.homeService.getAll()
            .pipe(first())
            .subscribe(clubList => this.clubs = clubList);
  }

}