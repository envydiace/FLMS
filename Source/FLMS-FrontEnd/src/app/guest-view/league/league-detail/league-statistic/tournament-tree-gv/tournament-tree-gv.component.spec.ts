import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { TournamentTreeGvComponent } from './tournament-tree-gv.component';

describe('TournamentTreeGvComponent', () => {
  let component: TournamentTreeGvComponent;
  let fixture: ComponentFixture<TournamentTreeGvComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ TournamentTreeGvComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TournamentTreeGvComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
