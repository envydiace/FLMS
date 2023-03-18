import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpUpdatePrizeComponent } from './pop-up-update-prize.component';

describe('PopUpUpdatePrizeComponent', () => {
  let component: PopUpUpdatePrizeComponent;
  let fixture: ComponentFixture<PopUpUpdatePrizeComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpUpdatePrizeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpUpdatePrizeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
