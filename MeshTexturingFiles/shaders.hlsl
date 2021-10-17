//*********************************************************
//
// Copyright (c) Microsoft. All rights reserved.
// This code is licensed under the MIT License (MIT).
// THIS CODE IS PROVIDED *AS IS* WITHOUT WARRANTY OF
// ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY
// IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR
// PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT.
//
//*********************************************************

struct PSInput
{
    float4 position : SV_POSITION;
    float2 uv : TEXCOORD;
};

Texture2D g_texture : register(t0);
SamplerState g_sampler : register(s0);

PSInput VSMain(float4 position : POSITION, float4 uv : TEXCOORD)
{
    PSInput result;

    float4 newPosition;
    float4 newUV;
    float angle = 1.0f;
   
    matrix <float, 4, 4> rotate = {
        cos(angle), 0.0f,   -sin(angle),    0.0f,
        0.0f,       1.0f,   0.0f,           0.0f,
        sin(angle), 0.0f,   cos(angle),     0.0f,
        0.0f,       0.0f,   0.0f,           1.0f
    };
    matrix <float, 4, 4> translate = {
        1.0f,    0.0f,       0.0f,    0.0f,
        0.0f,    1.0f,       0.0f,    0.0f,
        0.0f,    0.0f,       1.0f,    0.0f,
        0.0f,    0.0f,       0.2f,    1.0f
    };

    newPosition = mul(position, rotate);
    newPosition = mul(newPosition, translate);

    newUV = mul(uv, rotate);
    newUV = mul(newUV, translate);

    result.position = newPosition;
    result.uv = newUV;

    return result;
}

float4 PSMain(PSInput input) : SV_TARGET
{
    return g_texture.Sample(g_sampler, input.uv);
}
