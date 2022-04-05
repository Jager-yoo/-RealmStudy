# 🔮 Realm with SwiftUI

## 유튜브 Stewart Lynch 의 영상을 보고 적용해보는 레포입니다.

- [Part 1](https://youtu.be/nx3KDnqMU0M) - PropertyWrappers 1
- [Part 2](https://youtu.be/54d_0Mp4icA) - PropertyWrappers 2
- [Part 3](https://youtu.be/I6Yl9p_9WwE) - One Many Relationship 1

<br>

## 학습 내용

### ☑️ Realm 사용한 모델 타입 만들기

- [Object](https://www.mongodb.com/docs/realm-sdks/swift/latest/Extensions/Object.html) 는 프로토콜이 아니라 `클래스`입니다. Realm 을 사용한 `모델 타입`을 구현할 때, Object 클래스를 상속시킵니다.
> In Realm you define your model classes by subclassing Object and adding properties to be managed.<br>
> You then instantiate and use your custom subclasses instead of using the Object class directly.

- [ObjectKeyIdentifier](https://www.mongodb.com/docs/realm-sdks/swift/latest/Protocols/ObjectKeyIdentifiable.html) 프로토콜을 채택하면 자동으로 [Identifiable](https://developer.apple.com/documentation/swift/identifiable) 프로토콜을 준수합니다.
  - 그리고 `@Persisted(primaryKey: true) var id: ObjectId` 와 같이, `primaryKey` 역할을 하는 id 를 추가합니다.

- [ObjectId](https://www.mongodb.com/docs/realm-sdks/swift/latest/Classes/ObjectId.html) 클래스 타입의 프로퍼티는 12-byte 크기의 `unique object identifier`를 자동으로 생성합니다. (아래 캡처와 같이)
  - `ObjectId`를 기준으로 데이터를 정렬하면 `생성된 순서`와 동일한 결과를 얻을 수 있습니다.
  - `ForEach(toDos.sorted(byKeyPath: "id", ascending: false))` -> 이렇게 하면, 최근 생성된 것부터 내림차순 정렬되는 걸 확인했습니다.
> ObjectIds are intended to be fast to generate.<br>
> Sorting by an ObjectId field will typically result in the objects being sorted in creation order.

<img width="224" alt="image" src="https://user-images.githubusercontent.com/71127966/161750349-10824bfa-cb53-4802-a012-a87badf15a47.png">

- [@Persisted](https://www.mongodb.com/docs/realm-sdks/swift/latest/Structs/Persisted.html) 프로퍼티 wrapper 는 Realm 의 관리를 받고 싶은 프로퍼티 앞에 붙여줍니다.
> @Persisted is used to declare properties on Object subclasses which should be managed by Realm.

- 열거형(enum) 타입의 프로퍼티에 `@Persisted`를 붙여서, Realm 의 관리를 받고 싶다면, 2가지 조건이 필요합니다.
  - 먼저, 열거형이 `raw value(원시값)`를 가져야 합니다. 그래야 Realm 이 저장할 수 있습니다.
  - 그리고 그 열거형이 [PersistableEnum](https://www.mongodb.com/docs/realm-sdks/swift/latest/Protocols.html#/s:10RealmSwift15PersistableEnumP) 프로토콜을 채택해야 합니다.
> Persisting an enum in Realm requires that it have a raw value and that the raw value by a type which Realm can store.<br>
> The enum also has to be explicitly marked as conforming to this protocol as Swift does not let us do so implicitly.

```swift
import RealmSwift

final class ToDo: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var completed: Bool = false
    @Persisted var urgency: Urgency = .neutral
    
    enum Urgency: Int, PersistableEnum {
        
        case trivial
        case neutral
        case urgent
```
