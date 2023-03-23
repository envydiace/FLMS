import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { JoinedLeagueComponent } from './joined-league.component';

describe('JoinedLeagueComponent', () => {
  let component: JoinedLeagueComponent;
  let fixture: ComponentFixture<JoinedLeagueComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ JoinedLeagueComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(JoinedLeagueComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
