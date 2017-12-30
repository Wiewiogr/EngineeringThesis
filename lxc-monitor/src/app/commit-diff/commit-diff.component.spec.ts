import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { CommitDiffComponent } from './commit-diff.component';

describe('CommitDiffComponent', () => {
  let component: CommitDiffComponent;
  let fixture: ComponentFixture<CommitDiffComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ CommitDiffComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CommitDiffComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
