<?php

namespace App\Services\Account\Registration;

use DB;
use Hash;
use Log;
use App\Services\Api\Internal\NotifyApi;

class Email extends BaseRegistration
{
    protected $type = 1;

    protected function validate(array $input): bool
    {
        parent::validate($input);

        $rules['account'] = 'required|email';

        $validator = validator($input, $rules);
        if ($validator->fails()) {
            throw new App\Exceptions\InvalidParameterException($validator->errors()->first());
        }

        return true;
    }

    public function register(array $data): int
    {
        $this->validate($data);

        $nowDate = date('Y-m-d H:i:s');

        $insertData = [
            'sex' => $data['sex'] ?? null,
            'type' => $this->type,
            'reg_date' => $nowDate,
            'updated_at' => $nowDate,
            'password' => Hash::make($data['password']),
            'reg_email' => $data['account']
        ];

        try {
            $memberId = DB::table('member')->insertGetId($insertData);
        } catch (\Exception $e) {
            Log::error('新增會員資料失敗：' . $e->getMessage());
            throw new \App\Exceptions\DatabaseQueryException('新增會員資料失敗：' . $data['account'], 500, $e);
        }

        return $memberId;
    }

    public function getActivateCode(): string
    {
        return str_random(64);
    }

    /**
     * 寄送 email 驗證通知信
     *
     * @param array $data[
     *      @var string $email 會員 email
     *      @var int    $sex   性別
     *      @var string $code  驗證啟用碼
     * ]
     * @return boolean
     */
    public function notify(array $data): bool
    {
        $notify = new NotifyApi();

        $post = [
            'email' => $data['account'],
            'from' => 'service@test.com',
            'title' => '歡迎您成為 XXXX 網站的會員',
            'body' => view('notification.email.account.registration', $data)->render()
        ];

        return $notify->post('/email', $post);
    }
}
