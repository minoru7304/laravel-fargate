
<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>テスト</title>
</head>

<body>

    @if ($tasks->isNotEmpty())
        <ul>
            @foreach ($tasks as $task)
                <li>
                    {{ $task->name }}
                </li>
            @endforeach
        </ul>
    @endif

</body>

</html>
