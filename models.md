User

```
email:string
first_name:string
last_name:string
password:string

has_many :events
has_many :invitations
has_many :attend_events, through: :invitations, source: :event
```

Event

```
name:string
location:string
date:date
time:time

belongs_to :user
has_many :invitations
has_many :attendees, through: :invitations, source: :user
```

Invitation

```
belongs_to :user
belongs_to :event
```
